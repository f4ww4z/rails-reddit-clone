$(document).ready(function () {
    $(".vote").on("click", ".upvote, .downvote", function () {
        const post_id = $(this).parent().data("id")
        const is_upvote = $(this).hasClass("upvote")

        // console.log(`${is_upvote ? 'upvote' : 'downvote'} clicked for ${post_id}`)

        $.ajax({
            url: "/posts/vote",
            method: "POST",
            data: {upvote: is_upvote, post_id: post_id},
            success: function () {
                console.log(`successfully ${is_upvote ? 'upvoted' : 'downvoted'}`)
            }
        })
    })
})
