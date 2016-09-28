/* Show/hide button on admin page */
$('#collapsible').click(function(){
    $(this).text(function(i,old){
        return old=='Hide' ?  'Show' : 'Hide';
    });
});
