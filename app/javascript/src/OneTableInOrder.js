$(document).on('click', '.billing-checkbox', function(event) {
        $('.shipping').toggle()
        const is_one_table = $('#billing_address_is_one_table')

        if(is_one_table.val() == 0) {
                is_one_table.val(1)
        } else {
                is_one_table.val(0)
        }
})


