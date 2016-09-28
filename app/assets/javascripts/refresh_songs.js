$(document).ready (
    function () {
        setInterval(refreshSongs, 1500)
    }
);

function refreshSongs() {
    $.ajax({
        url: "refresh_songs",
    })
}
