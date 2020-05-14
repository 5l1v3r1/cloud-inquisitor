{
    "Comment": "Tag Auditor that tracks a resource over N stages",
    "StartAt": "Init",
    "States": {
        "Init": {
            "Type": "Task",
            "Resource": "${tag_auditor_init}",
            "Next": "Check if Fixed After Init"
        },
        "Check if Fixed After Init": {
            "Type": "Choice",
            "Choices": [
                {
                    "Variable": "$.Finished",
                    "BooleanEquals": false,
                    "Next": "Wait For First Notification"
                },
                {
                    "Variable": "$.Finished",
                    "BooleanEquals": true,
                    "Next": "Resource Has Been Remediated"
                }
            ]
        },
        "Wait For First Notification" : {
            "Type": "Wait",
            "Seconds": ${init_seconds},
            "Next": "First Notification"
        },
        "First Notification": {
            "Type": "Task",
            "Resource": "${tag_auditor_notify}",
            "Next": "Check if Fixed After First Notification"
        },
        "Check if Fixed After First Notification": {
            "Type": "Choice",
            "Choices": [
                {
                    "Variable": "$.Finished",
                    "BooleanEquals": false,
                    "Next": "Wait For Second Notification"
                },
                {
                    "Variable": "$.Finished",
                    "BooleanEquals": true,
                    "Next": "Resource Has Been Remediated"
                }
            ]
        },
        "Wait For Second Notification" : {
            "Type": "Wait",
            "Seconds": ${first_notify_seconds},
            "Next": "Second Notification"
        },
        "Second Notification": {
            "Type": "Task",
            "Resource": "${tag_auditor_notify}",
            "Next": "Check if Fixed After Second Notification"
        },
        "Check if Fixed After Second Notification": {
            "Type": "Choice",
            "Choices": [
                {
                    "Variable": "$.Finished",
                    "BooleanEquals": false,
                    "Next": "Wait For Third Notification"
                },
                {
                    "Variable": "$.Finished",
                    "BooleanEquals": true,
                    "Next": "Resource Has Been Remediated"
                }
            ]
        },
        "Wait For Third Notification" : {
            "Type": "Wait",
            "Seconds": ${second_notify_seconds},
            "Next": "Third Notification"
        },
        "Third Notification": {
            "Type": "Task",
            "Resource": "${tag_auditor_notify}",
            "Next": "Check if Fixed After Third Notification"
        },
        "Check if Fixed After Third Notification": {
            "Type": "Choice",
            "Choices": [
                {
                    "Variable": "$.Finished",
                    "BooleanEquals": false,
                    "Next": "Wait For Prevent"
                },
                {
                    "Variable": "$.Finished",
                    "BooleanEquals": true,
                    "Next": "Resource Has Been Remediated"
                }
            ]
        },
        "Wait For Prevent" : {
            "Type": "Wait",
            "Seconds": ${prevent_seconds},
            "Next": "Prevent"
        },
        "Prevent": {
            "Type": "Task",
            "Resource": "${tag_auditor_prevent}",
            "Next": "Check if Fixed After Prevent"
        },
        "Check if Fixed After Prevent": {
            "Type": "Choice",
            "Choices": [
                {
                    "Variable": "$.Finished",
                    "BooleanEquals": false,
                    "Next": "Wait For Remove"
                },
                {
                    "Variable": "$.Finished",
                    "BooleanEquals": true,
                    "Next": "Resource Has Been Remediated"
                }
            ]
        },
        "Wait For Remove" : {
            "Type": "Wait",
            "Seconds": ${remove_seconds},
            "Next": "Remove"
        },
        "Remove": {
            "Type": "Task",
            "Resource": "${tag_auditor_remove}",
            "Next": "Resource Has Been Remediated"
        },
        "Resource Has Been Remediated": {
            "Type": "Succeed"
        }
    }
}