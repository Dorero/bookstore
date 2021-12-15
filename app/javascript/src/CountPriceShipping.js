$(document).on('click', '.deliveries', function(event) {
    if($(event.target).attr('class')  == 'radio-input' ) {
        const coupon = $('.coupon').text()
        const discount = parseFloat((coupon.substr(1, coupon.length)))
        const deliveryPrice = parseFloat($(event.target).val())
        const subTotalOrderField = $('.sub-total-order')
        const subTotalPrice = parseFloat(subTotalOrderField.text().substr(1, subTotalOrderField.text().length).replaceAll(',', ''))
        let orderTotalPrice = (subTotalPrice + deliveryPrice) - discount

        if(orderTotalPrice >= 1000) {
            let price = String(orderTotalPrice)
            orderTotalPrice = price[0] + ',' + price.substr(1, price.length)
        }

        $('.shipping').text(`€${deliveryPrice.toFixed(2)}`)
        $('.order-total-price').text(`€${orderTotalPrice}`)
    }
})

