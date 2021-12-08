$(document).on('click', '.price-field', function(event) {
    event.preventDefault()

    const fieldQuantity = $($(this).children('input')[0])

    if(event.target === $('.fa-plus').get(0))  plus(fieldQuantity)
    if(event.target === $('.fa-minus').get(0)) minus(fieldQuantity)
})


const plus = (fieldQuantity) => {
    const newQuantity = fieldQuantity.val() ? parseFloat(fieldQuantity.val()) + 1 : 1

    fieldQuantity.val(newQuantity)
}

const minus = (fieldQuantity) => {
    let newQuantity = fieldQuantity ? fieldQuantity.val() - 1 : 0

    if (newQuantity < 1)  newQuantity = 1;

    fieldQuantity.val(newQuantity)
}

$(document).on('input', '.quantity-input', function() {
    const amount = parseInt($(this).val())
    if (amount < 1 || !Number.isInteger(amount)) {
        $(this).val(1)
    }
})

$(document).on('change input', '.send', function() {
    const subTotalPriceField = $($(this).parent().parent().siblings()[3].childNodes[1])
    const sign = subTotalPriceField.text()[0]

    $.post('/cart/update_prices', { quantity_books: $(this).val(), book_id: $('#book_id').val() }, function(data){
        $(this).val(data.quantity_books)
        subTotalPriceField.text(`${sign}${data.sub_total_price}`)
        $('.sub-total-order').text(`${sign}${data.sub_total_order_price}`)
        $('.coupon').text(`${sign}${data.discount.toFixed(2)}`)
        $('.order-total-price').text(`${sign}${data.order_total_price}`)
    });
})
