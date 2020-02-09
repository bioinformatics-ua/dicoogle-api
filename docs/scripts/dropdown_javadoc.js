$(document).ready(function () {
    $("#navbarDropdownMenuLink").text($("#master").text());
    $('.dropdown-menu a').click(function () {
        $("#navbarDropdownMenuLink").text($(this).text());
        let version = $(this).text();
        let newSrc = "https://bioinformatics-ua.github.io/dicoogle-api/javadoc/" + version;
        $("#main-iframe").attr('src', newSrc);
    });
});