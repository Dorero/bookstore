$(document).on('click', 'a.read-more', (event) => {
    event.preventDefault()

    const paragraph = $('p.lead.small.line-height-2')
    const description = $('.hidden-description').val()

    $(paragraph).text(description)
    createButton('read-less', paragraph, 'Read less')

    $('a.read-less').on('click', (event) => {
        event.preventDefault()

        const text = description.slice(0, 250)

        $(paragraph).text(text)
        createButton('read-more', paragraph, 'Read more')
    })
})

const createButton = (marker, container, text) => {
    const button = `<a class="in-gold-500 ml-10 ${marker}" href="#">${text}</a>`
    $(container).append(button)
}
