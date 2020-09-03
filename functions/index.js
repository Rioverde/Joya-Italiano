const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);

var newData;

exports.onCreateTrigger = functions.firestore.document('Users/{users}').onCreate(async(snapshot, context) => {
    //


    if (snapshot.empty) {
        console.log('No Devices');
        return;
    }

    newData = snapshot.data();


    const deviceIdTokens = await admin
        .firestore()
        .collection('tokens')
        .get();

    var tokens = [];

    for (var token of deviceIdTokens.docs) {
        tokens.push(token.data().device_token);


    }
    var payload = {
        notification: {
            title: 'Joya Reservations',
            body: 'New user reserved place',
            sound: 'default',
        },
    };

    try {
        console.log('Notification sent successfully');
        await admin.messaging().sendToDevice(tokens, payload);


    } catch (err) {
        console.log(err);
    }
});


exports.onUpdateTrigger = functions.firestore.document('Users/{users}').onUpdate(async(change, context) => {
    //
    const before = change.before.data();
    const after = change.after.data();

    var payload = {
        notification: {
            title: 'Joya Reservations',
            body: 'User updated reservation',
            sound: 'default',
        },
    };

    var tokens = [];

    const deviceIdTokens = await admin
        .firestore()
        .collection('tokens')
        .get();


    for (var token of deviceIdTokens.docs) {
        tokens.push(token.data().device_token);
    }

    if (before.text === after.text) {
        try {
            console.log('Notification sent successfully');
            await admin.messaging().sendToDevice(tokens, payload);


        } catch (err) {
            console.log(err);
        }
    } else {
        console.log('no changes');
    }


});