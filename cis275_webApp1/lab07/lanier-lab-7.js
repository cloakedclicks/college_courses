"use strict";

var $ = function(id) {
    return document.getElementById(id);
};

var clearTextboxes = function(){
    $("degrees-entered").value = "";
    $("degrees-computed").value = "";
    $("degrees-entered").focus();
};

var toFahrenheit = function(){
    $("degrees-top-label").firstChild.nodeValue = "Enter Celsius degrees:";
    $("degrees-bottom-label").firstChild.nodeValue = "Fahrenheit equivalent:";
    clearTextboxes();
};

var toCelsius = function() {
    $("degrees-top-label").firstChild.nodeValue = "Enter Fahrenheit degrees:";
    $("degrees-bottom-label").firstChild.nodeValue = "Celsius equivalent:";
    clearTextboxes();
};

var convertTemperature = function() {
    var celsius = 0;
    var fahrenheit = 0;

    if($("to-fahrenheit").checked == true){
        celsius = parseFloat($("degrees-entered").value);
        if (isNaN(celsius)){
            alert("A number must be entered.");
        } else {
            fahrenheit = parseFloat((celsius * (9 / 5)) + 32).toFixed(0);
            $("degrees-computed").value = fahrenheit;
        }

    } else {
        fahrenheit = parseFloat($("degrees-entered").value);
        if (isNaN(fahrenheit)){
            alert("A number must be entered.");
        } else {
            celsius = parseFloat((fahrenheit - 32) * (5 / 9)).toFixed(0);
            $("degrees-computed").value = celsius;
        }
    }
};

window.onload = function () {
    $("to-fahrenheit").onclick = toFahrenheit;
    $("to-celsius").onclick = toCelsius;
    $("convert").onclick = convertTemperature;
};