if(window.location.href.includes('books/')) {
    $(document).ready(() => {
        computingAmount();
        document.addEventListener('load', computingAmount)
    });
}


const computingAmount = () => {
        let priceField = $("p.in-gold-500")
        let price = priceField.text()
        let originalAmount = parseFloat(price.slice(1, price.length))
        let plus = $(".fa-plus")
        let minus = $(".fa-minus")
        let fieldQuantity = $(".quantity-input")

        $(plus).click(function(event){
            event.preventDefault()

            let price = priceField.text()
            let sign = price[0]
            let amount = parseFloat(price.slice(1, price.length))
            let newQuantity = fieldQuantity.val() ? parseFloat(fieldQuantity.val()) + 1 : 1
            let newPrice = (amount + originalAmount).toFixed(2)

            fieldQuantity.val(newQuantity)

            priceField.text(sign + newPrice)
        });

        $(minus).click(function(event){
            event.preventDefault()

            let price = priceField.text()
            let sign = price[0]
            let amount = parseFloat(price.slice(1, price.length))
            let newQuantity = fieldQuantity ? fieldQuantity.val() - 1 : 0
            let newPrice = originalAmount

            if (newQuantity < 0)  newQuantity = 0;
            if (newQuantity > 0)  newPrice = (amount - originalAmount).toFixed(2);

            fieldQuantity.val(newQuantity)
            priceField.text(sign + newPrice)
        });
}
