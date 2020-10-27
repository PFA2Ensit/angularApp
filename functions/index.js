const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();


exports.onCreateActivityFeedItem = functions.firestore
.document('/feed/{id}/feedItems/{activityFeedItem}')
.onCreate(async (snapshot, context) =>
{
    const id = context.params.id;
    const userRef = admin.firestore().doc(`users/${id}`);
    const doc = await userRef.get();


    const androidNotificationToken = doc.data().androidNotificationToken;
    const createActivityFeedItem = snapshot.data();

    if(androidNotificationToken)
    {
        sendNotification(androidNotificationToken, createActivityFeedItem);
    }
    else
    {
        console.log("No token for user, can not send notification.")
    }

    function sendNotification(androidNotificationToken, activityFeedItem)
    {
        let body;

        switch (activityFeedItem.type)
        {
            case "comment":
                body = `${activityFeedItem.username} sent comment: ${activityFeedItem.commentData}`;
                break;

            case "like":
                body = `${activityFeedItem.username} liked your post`;
                break;

            case "articleAdded":
                body = `${activityFeedItem.username} added new post`;
                break;

            default:
            break;
        }

        const message =
        {
            notification: { body },
            token: "ctoZJQYm27s:APA91bFEIdsBSvTy1sfBJEW4GTb_GuXajxuxiMweQ2wg8DHyKuu15RS8dsvOz34ImCdt-77m48gUwYsQlPisBl2siUzQ45wsc684hMmNlbLBnIpECvqdoI9yWc4kvJmsjAHIXWZD3WB-",
            data: { recipient: id },
        };

        admin.messaging().send(message)
        .then(response =>
        {
            console.log("Successfully sent message", response);
        })
        .catch(error =>
        {
            console.log("Error sending message", error);
            console.log(token);
            console.log(body);
        })

    }
});
