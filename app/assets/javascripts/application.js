// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks


function getBrowserHeight() {
    var intH = 0;
    var intW = 0;

    if(typeof window.innerWidth  == 'number' ) {
        intH = window.innerHeight;
        intW = window.innerWidth;
    }
    else if(document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
        intH = document.documentElement.clientHeight;
        intW = document.documentElement.clientWidth;
    }
    else if(document.body && (document.body.clientWidth || document.body.clientHeight)) {
        intH = document.body.clientHeight;
        intW = document.body.clientWidth;
    }

    return { width: parseInt(intW), height: parseInt(intH) };
}

function setLayerPosition(background, main) {
    var shadow = document.getElementById(background);
    var question = document.getElementById(main);

    var bws = getBrowserHeight();
    shadow.style.width = bws.width + "px";
    shadow.style.height = bws.height + "px";

    question.style.left = parseInt((bws.width - 350) / 11);
    question.style.top = parseInt((bws.height - 200) / 15);

    shadow = null;
    question = null;
}

function showLayer(background, main) {
    setLayerPosition(background, main);

    var shadow = document.getElementById(background);
    var question = document.getElementById(main);

    shadow.style.display = "block";
    question.style.display = "block";

    shadow = null;
    question = null;
}

function hideLayer(background,main) {
    var shadow = document.getElementById(background);
    var question = document.getElementById(main);

    shadow.style.display = "none";
    question.style.display = "none";

    shadow = null;
    question = null;
}

function confirmAction(actionUrl, message)
{
    showLayer('shadow', 'question')
    document.getElementById("bttnYes").setAttribute("onmousedown", "window.location='"+actionUrl + "'")
}