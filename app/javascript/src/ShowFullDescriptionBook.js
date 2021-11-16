if(window.location.href.includes('books/')) {
    $(document).ready(() => {
        let moreInfoButton = $('a.in-gold-500')
        let fullDescription = $('.hidden-description').val()
        let paragraphWithDescription = $('p.lead.small.line-height-2')
        $(moreInfoButton).on('click', (event) => {
            event.preventDefault()
            paragraphWithDescription.text(fullDescription)
        })
    });
}
