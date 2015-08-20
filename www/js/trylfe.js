var description = "It is pitch black.\n\nBut that's okay -- you can code " +
                  "in the dark.\n";
var welcomeMessage = "You wake up. The room is spinning very gently round " +
                     "your head. Or at\nleast it would be if you could see " +
                     "it, which you can't.\n\n" + description + "\n";
var cmdHelp = "help    - this message (to get LFE REPL help, use '(help)')\n" +
              "next    - move on to the next exercise\n" +
              "back    - move back to the previous exercise\n" +
              "restart - start the tutorial over again\n" +
              "inv     - inventory\n" +
              "look    - describe your surroundings\n"
var currentPage = -1;
var pages = [
            "page1",
            "page2",
            "page3",
            "page4",
            "page5",
            "page6",
            "page7",
            "page8",
            "page9",
            "page10",
            "page11",
            "end"
        ];
var pageExitConditions = [
    {
        verify: function(data) { return false; }
    },
    {
        verify: function(data) { return data.expr == "(+ 3 3)"; }
    },
    {
        verify: function(data) { return data.expr == "(/ 10 3)"; }
    },
    {
        verify: function(data) { return data.expr == "(/ 10 3.0)"; }
    },
    {
        verify: function(data) { return data.expr == "(+ 1 2 3 4 5 6)"; }
    },
    {
        verify: function (data) { return data.expr == "(defun square (x) (* x x))"; }
    },
    {
        verify: function (data) { return data.expr == "(square 10)"; }
    },
    {
        verify: function (data) { return data.expr == "((lambda (x) (* x x)) 10)"; }
    },
    {
        verify: function (data) { return data.expr == "(set square (lambda (x) (* x x)))"; }
    },
    {
        verify: function (data) { return data.expr == "(lists:foldl #'+/2 1 '(1 2 3 4))"; }
    },
    {
        verify: function (data) { return false; }
    },
    {
        verify: function (data) { return false; }
    }
];

function goToPage(pageNumber) {
    if (pageNumber == currentPage || pageNumber < 0 || pageNumber >= pages.length) {
            return;
    }

    currentPage = pageNumber;

    var block = $("#changer");
      block.fadeOut(function(e) {
        block.load("/tutorial/" + pages[pageNumber] + ".html", function() {
      block.fadeIn();
      changerUpdated();
        });
    });
}

function eval_lfe(code) {
    var data;
    $.ajax({
        url: "eval.json",
        data: { expr : code },
        async: false,
        success: function(res) { data = res; }
    });
    return data;
}

function html_escape(val) {
    var result = val;
    result = result.replace(/\n/g, "<br/>");
    result = result.replace(/[<]/g, "&lt;");
    result = result.replace(/[>]/g, "&gt;");
    return result;
}

function doCommand(input) {
    if (input.match(/^gopage /)) {
        goToPage(parseInt(input.substring("gopage ".length)));
        return true;
    }

    switch (input) {
        case 'next':
        case 'forward':
            goToPage(currentPage + 1);
            return true;
        case 'previous':
        case 'prev':
        case 'back':
            goToPage(currentPage - 1);
            return true;
        case 'restart':
        case 'reset':
        case 'start':
        case 'home':
        case 'quit':
        case 'exit':
            goToPage(0);
            return true;
        case 'inv':
        case 'inventory':
            return {"msg": "You're not carrying anything. (You're writing code, not space-adventuring!)\n"};
        case 'light':
        case 'turn on light':
            return {"msg": "What do you need a light for?! You can code in the dark ...\n"};
        case 'look':
        case 'describe':
            return {"msg": description};
        case '42':
            return {"msg": "Yes, but what is the *question*?"};
        case 'answer':
            return {"msg": 42};
        case '?':
        case 'help':
            return {"msg": cmdHelp};
        default:
            return false;
    }
}

function onValidate(input) {
    return (input != "");
}

function onHandle(line, report) {
    var input = $.trim(line);

    // handle commands
    var data = doCommand(input);
    if (data == true) {
        report();
        return;
    } else if (typeof(data) == 'object') {
        return [{msg: data.msg, className: "jquery-console-message-value"}];
    } else {
        // perform evaluation
        data = eval_lfe(input);
    }

    // handle error
    if (data.error) {
        return [{msg: data.message, className: "jquery-console-message-error"}];
    }

    // handle page
    if (currentPage >= 0 && pageExitConditions[currentPage].verify(data)) {
              goToPage(currentPage + 1);
    }

    // display expr results
    return [{msg: data.result, className: "jquery-console-message-value"}];
}

/**
 * This should be called anytime the changer div is updated so it can rebind event listeners.
 * Currently this is just to make the code elements clickable.
 */
function changerUpdated() {
    $("#changer code.expr").each(function() {
        $(this).css("cursor", "pointer");
        $(this).attr("title", "Click to insert '" + $(this).text() + "' into the console.");
        $(this).click(function(e) {
            controller.promptText($(this).text());
            controller.inner.click();
        });
    });
}

var controller;

$(document).ready(function() {
    controller = $("#console").console({
        welcomeMessage: welcomeMessage,
        promptLabel: 'lfe> ',
        commandValidate: onValidate,
        commandHandle: onHandle,
        autofocus:true,
        animateScroll:true,
        promptHistory:true
    });

    changerUpdated();
});
