$(document).ready (
    function () {
        setInterval(refreshPartial, 1000)
    }
);

function refreshPartial() {
    $.ajax({
        url: "refresh_top_songs",
    })
}
