$(window).on('load', () => {
    $(".rating").starRating({
        totalStars: 5,
        starSize: 25,
        disableAfterRate: false,
        useFullStars: true,
        ratedColors: ["#ffa500", "#ffa500", "#ffa500", "#ffa500", "#ffa500"],
        callback: function(currentRating, $el){
            $('#review_stars').val(currentRating)
        }
    });

    $('.ml-70').each((index) => {
        const readRating = $(`.stars-${index}`)
        readRating.starRating({
            starSize: 25,
            readOnly: true,
            initialRating: readRating.attr('data-stars'),
            ratedColors: ["#ffa500", "#ffa500", "#ffa500", "#ffa500", "#ffa500"]
        })
    })
})


