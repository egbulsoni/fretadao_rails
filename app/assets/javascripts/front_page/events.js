$.ajax({
    url: "/sub_comments",
    type: "POST",
    data: {subcomment: {
             field: val,
             field2: val, etc... }},
    success: function(resp){ }
});
