function setup() {
    createCanvas(400, 400);         // just to make sure p5 is working
    
    let allData = {
        entries: []
    }
    
    var firebaseConfig = {
        apiKey: '',
        authDomain: '',
        projectId: '',
      };
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
    let db = firebase.firestore();
    
    db.collection('colors').get().then((querySnapshot) => {
        querySnapshot.forEach((doc) => {                        // get all the docs
            allData.entries.push(doc.data());                   // add each doc to the array
        });
        saveJSON(allData, 'colorData.json');                    // save as json
    });
    
}

function draw() {

}