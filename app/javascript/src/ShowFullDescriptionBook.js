$(document).on('click', 'a.in-gold-500', (event) => {
    event.preventDefault()
    $('p.lead.small.line-height-2').text($('.hidden-description').val())
})
