$(document).on('click', '.price-field', function(event) {
    event.preventDefault()

    let params = { fieldQuantity: $(this).children('input')}
    let plusElement = $('.fa-plus').get(0)
    let minusElement = $('.fa-minus').get(0)


    if ($('.price').text().length) {
        const priceField = $($(this).parent().siblings()[3].childNodes[1])
        const originalPriceField = $($(this).parent().siblings()[2].childNodes[1])
        const price = priceField.text()
        const sign = price[0]
        const amount = parseFloat(price.slice(1, price.length))

        params =  {
            priceField: priceField,
            originalAmount: parseFloat(originalPriceField.text().substring(1)),
            fieldQuantity: $(this).children('input'),
            price: price,
            sign: sign,
            amount: amount
        }

        plusElement = $(this).children('a')[1].childNodes[1]
        minusElement = $(this).children('a')[0].childNodes[1]
    }

    if(event.target === plusElement)  plus(params)
    if(event.target === minusElement) minus(params)
})


const plus = (props) => {
    let newQuantity = props.fieldQuantity.val() ? parseFloat(props.fieldQuantity.val()) + 1 : 1

    props.fieldQuantity.val(newQuantity)

    if($('.price').text().length) {
        let newPrice = (props.amount + props.originalAmount).toFixed(2)
        props.priceField.text(props.sign + newPrice)
    }
}

const minus = (props) => {
    let newQuantity = props.fieldQuantity ? props.fieldQuantity.val() - 1 : 0

    if (newQuantity < 1)  newQuantity = 1;

    props.fieldQuantity.val(newQuantity)

    if($('.price').text().length) {
        let newPrice = props.originalAmount
        if (newQuantity > 1)  newPrice = (props.amount - props.originalAmount).toFixed(2);
        props.priceField.text(props.sign + newPrice)
    }

}

$(document).on('input', '.quantity-input', function(event) {
    const amount = parseInt($(this).val())

    if (amount < 1 || !Number.isInteger(amount)) {
        $(this).val(1)
    } else {

        if ($('.price').text().length) {
            const priceField = $($(this).parent().parent().siblings()[3].childNodes[1])
            const originalPriceField = $($(this).parent().parent().siblings()[2].childNodes[1])
            priceField.text(`${priceField.text()[0]}${originalPriceField.text().substring(1) * amount}`)
        }
    }
})
