$(document).on('click', '.btn.btn-primary', (event) => {
    const button = $('.btn.btn-primary')
    $.ajax({
        url: '/api/books',
        dataType: 'json',
        data: {category: button.attr('category'), sort: button.attr('sort'), page: button.attr('page')},
        method: 'get',
        success: (books) => {
            console.log(books)
            books.forEach(book => render(book))
        }
    });
})

const render = (book) => {
    const container = $('#books_list')
    const html = `
        <div class="col-xs-6 col-sm-3">
            <div class="general-thumb-wrap">
                <div class="thumbnail general-thumbnail">
                <img alt="design-book" class="img-shadow general-thumbnail-img" src=${book.image}>
                    <div class="thumb-hover">
                        <div class="general-thumb-link-wrap">
                        <a class="thumb-hover-link" href="/books/19?sort=price_low">
                            <i aria-hidden="true" class="fas fa-eye thumb-icon"></i>
                        </a>
                        <a class="thumb-hover-link" href="#">
                            <i class="fas fa-shopping-cart thumb-icon"></i>
                        </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="general-thumb-info">
                <p class="title">${book.name}</p>
                <p class="font-16 in-gold-500">€${book.price}/p>
                <span class="divider-sm"></span>
                <p class="lead small">No author</p>
            </div>
        </div>
    `
    container.append(html)
}
