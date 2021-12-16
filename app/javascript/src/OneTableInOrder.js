$(document).on('click', '.billing-checkbox', function(event) {
        const shipping = $('.shipping')
        const is_one_table = $('#address_billing_address_is_one_table')

        shipping.toggle()

        if(is_one_table.val() == 0) {
                is_one_table.val(1)
        } else {
                is_one_table.val(0)
        }
})


