$(document).on('mouseover', '.star', function() {
    const current = $(this)

    $('.star').each(function(index) {
        $(this).addClass('hovered-stars')
        if(index === current.index()) return false;
    })
})

$(document).on('mouseleave', '.star', function() {
    $('.star').removeClass('hovered-stars')
})

$(document).on('click', '.star', function() {
    $('.star').removeClass('clicked-stars')
    $('.hovered-stars').addClass('clicked-stars')
    console.log($(this).children().attr('id'), $(this).children())
    $('#review_stars').val($(this).children().attr('id'))
})
