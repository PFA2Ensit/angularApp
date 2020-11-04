const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const settings = {/* your settings... */ timestampsInSnapshots: true};
admin.firestore().settings(settings);


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
                body = `${activityFeedItem.username} sent comment: ${activityFeedItem.comment}`;
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

        var tokens = ['fjiuZ3YqHyk:APA91bGCxzAcEMgwRoVLVg5T3qj_GTidEp0FZz4nv_e0tF2lDRiaK4oJZg-U_NmCX1uSGYmk5MihWvlwFB_fO3W_sOXfyKKlYUxEev4sWxE-LVUqwmPd0ABNQxWoFULKnuXBBOWkFjo5'];


        const message =
        {
            notification: { body },
           // token: 'erI48pc6kPE:APA91bF6pN03lwhTvfTJcz22LeZW8gD7GMSHW6wiO2vZoNHBsXlQyIoEwr9pFPQG709qKaYBHMbFRLbpKT72B1zyGM9Rl1BeutgIEUdYf-ehLMe23YluwbNBGkXa0ijDBdOZLwyY_PyW',
            data: { recipient: id },
        };

        var payload = {
            notification: {
                //title: 'Push Title',
                body: body,
                sound: 'default',
            },
            data: {
                push_key: 'Push Key Value',
                key1: 'sample message',
            },
        };

        admin.messaging().sendToDevice(tokens,payload)
        .then(response =>
        {
            console.log("Successfully sent message", response);
            console.log(response.results[0].error);
        })
        .catch(error =>

        {
            
            console.log(body);
            console.log(androidNotificationToken);
            console.log("Error sending message", error);
           
        })

    }
});
