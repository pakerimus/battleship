/*global $*/

var cell;

$(function () {

    'use strict';

    $("[data-behavior~=cell]").click(function (e) {
        e.preventDefault();
        cell = $(this);
        alert("clicked on " + cell.data("cell"));
        console.log(cell.data("shot-url"));
        //TODO: submit shot, response and process it
    });

});
