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

function showDispenseForm()
{
  showLayer('shadow', 'dispenseForm')
}

function createDirections(route, dose, frequency)
{
    routes = {"oral":"Take", "topical":"Apply", "injection":"Inject","respiratory":"Inhale","other":""}
    frequencies = {"OD": "Once a day", "BD":"Twice a day", "TDS":"Three times a day", "QID":"Four times a day",
                    "5XD":"Five times a day", "Q4HRS":"Six times a day","QOD":"Every other day",
                    "QWK":"Once a week"}

    return routes[route.toLowerCase()] + " "+ dose + " " + frequencies[frequency];
}

function calcQuantity(dose, frequency,duration) {
    frequencies = {"OD": 1, "BD":2, "TDS":3, "QID":4, "5XD":4, "Q4HRS":6,"QOD":0.5, "QWK":0.14};
    
    return ((dose * frequencies[frequency] * duration) == NaN ? 0 : Math.ceil(dose * frequencies[frequency] * duration))
}

function getCharButtonSetID(character,id){
    return '<button onMouseDown="press(\''+character+'\');" class="keyboardButton" id="'+id+'">' +"<span style='width:32px'>"+character+"</span>"+ "</button>";
}
function getButtonString(id,string){
    return "<button \
                            onMouseDown='press(this.id);' \
                            class='keyboardButton' \
                            id='"+id+"'>"+
        string +
        "</button>";
}

function getButtons(chars){
    var buttonLine = "";
    for(var i=0; i<chars.length; i++){
        character = chars.substring(i,i+1)
        buttonLine += getCharButtonSetID(character,character)
    }
    return buttonLine;
}

function showAlphaKeypad(){
    document.getElementById("keypad").style.height = "280";
    keyboard.innerHTML= getButtons("0123456789") + "</br>"
    keyboard.innerHTML+= getButtons("QWERTYUIOP") + "</br>"
    keyboard.innerHTML+= getButtons("ASDFGHJKL:") + "</br>"
    keyboard.innerHTML+= getButtons("ZXCVBNM,.?")
    keyboard.innerHTML+= getButtonString('backspace','<span>Bksp</span>')
    keyboard.innerHTML+= getButtonString('Space','<span>Space</span>')
    keyboard.innerHTML+= getButtonString('clear','<span>Clear</span>')
}

function showNumericKeypad(){
    document.getElementById("keypad").style.height = "145";
    keyboard.innerHTML = getButtons("123")
    keyboard.innerHTML+= getButtons("456")
    keyboard.innerHTML+= getButtons("7890")
    keyboard.innerHTML+= getButtonString('space','<span>Space</span>')
    keyboard.innerHTML+= getButtonString('clear','<span>Clear</span>')
    keyboard.innerHTML+= getButtonString('backspace','<span>Bksp</span>')
    keyboard.innerHTML+= getButtonString('abc','<span>abc</span>')
    keyboard.innerHTML+= getButtonString('dash','<span>-</span>')
    keyboard.innerHTML+= getButtonString('slash','<span>/</span>')
}

function showKeyboard(){
    key = document.getElementById("keypad")
    if(key.style.display == 'none' || key.style.display == ""){
        key.style.display = "inline";
        return
    }

    key.style.display = "none";
}

function press(pressedChar){
    switch (pressedChar) {
        case 'backspace':
            search.value = search.value.substring(0,search.value.length-1);
            search_box.fnFilter(search.value)
            return;
        case 'Space':
            search.value+= " "
            search_box.fnFilter(search.value)
            return
        case 'clear':
            search.value = ""
            search_box.fnFilter(search.value)
            return
        case 'num':
            showNumericKeypad();
            return
        case 'slash':
            search.value+= "/"
            search_box.fnFilter(search.value)
            return
        case 'dash':
            search.value+= "-"
            search_box.fnFilter(search.value)
            return
        case 'abc':
            showAlphaKeypad();
            return
    }
    search.value+= pressedChar
    search_box.fnFilter(search.value)
}
