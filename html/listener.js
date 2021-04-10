$(function(){

    function display(state) {
        if (state) {
            $("#container").show();
        }
        else {
            $("#container").hide();
        }
    }

    document.onkeyup = function(e){
        if (e.key == 'Escape') {
            display(false);
            $.post("https://anim_viewer/closeUI", JSON.stringify({}));
        }
    }

    window.addEventListener('message', function(event){
        let item = event.data;
        if (item.type == 'enable') {
            display(true)
        }
    })
})