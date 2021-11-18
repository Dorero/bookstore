$(document).on('click', '.input-group.general-position', (event) => {
    event.preventDefault()

    const priceField = $("p.in-gold-500")
    const price = priceField.text()
    const sign = price[0]
    const amount = parseFloat(price.slice(1, price.length))

    const params = {
        priceField: priceField,
        originalAmount: parseFloat($(".hidden-amount").val()),
        fieldQuantity: $(".quantity-input"),
        price: price,
        sign: sign,
        amount: amount
    }

    if(event.target === $('.fa-plus').get(0)) plus(params)
    if(event.target === $(".fa-minus").get(0)) minus(params)
})

const plus = (props) => {
    let newQuantity = props.fieldQuantity.val() ? parseFloat(props.fieldQuantity.val()) + 1 : 1
    let newPrice = (props.amount + props.originalAmount).toFixed(2)

    props.fieldQuantity.val(newQuantity)
    props.priceField.text(props.sign + newPrice)
}

const minus = (props) => {
    let newQuantity = props.fieldQuantity ? props.fieldQuantity.val() - 1 : 0
    let newPrice = props.originalAmount

    if (newQuantity < 1)  newQuantity = 1;
    if (newQuantity > 1)  newPrice = (props.amount - props.originalAmount).toFixed(2);

    props.fieldQuantity.val(newQuantity)
    props.priceField.text(props.sign + newPrice)
}
