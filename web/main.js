let data;
let labelList = [
    'RED',
    'ORANGE',
    'YELLOW',
    'GREEN',
    'BLUE',
    'INDIGO',
    'VIOLET'
];
let model;
let xs, ys;
let lossP, labelP;
let redSlider, greenSlider, blueSlider;

function preload() {
    data = loadJSON('colorData.json');
}

function setup() {

    lossP = createP('Loss')
    labelP = createP('');
    redSlider = createSlider(0, 255, 255);
    greenSlider = createSlider(0, 255, 255);
    blueSlider = createSlider(0, 255, 255);

    console.log(data.entries.length);

    // we need to work with tensors!
    let colors = [];
    let labels = [];

    for (let record of data.entries) {
        let col = [record.red / 255, record.green / 255, record.blue / 255];    // normalize
        colors.push(col);                                                       // add 3 rbg array to input array
        labels.push(labelList.indexOf(record.label));                           // add the index of the label
    }
    xs = tf.tensor2d(colors);                     
    let labelsTensor = tf.tensor1d(labels, 'int32');   
    ys = tf.oneHot(labelsTensor, 7);

    labelsTensor.dispose();         // intermediate, we can dispose

    // SANITY CHECK
    console.log(xs.shape);
    console.log(ys.shape);
    xs.print();
    ys.print();

    // architect the model
    model = tf.sequential();
    let hidden = tf.layers.dense({
        units: 16,
        activation: 'sigmoid',
        inputShape: [3]
    });
    let output = tf.layers.dense({
        units: 7,
        activation: 'softmax'
    });
    model.add(hidden);
    model.add(output);

    // optimizer
    const learningRate = 0.2;
    const optimizer = tf.train.sgd(learningRate);

    // compile
    model.compile({
        optimizer: optimizer,
        loss: 'categoricalCrossentropy'     // better for categorization 
    });

    train().then()


}

async function train() {
    const options = {
        epochs: 20,
        validationSplit: 0.1,       // split out 10% for validation
        shuffle: true,              // shuffle the order for each epoch
        callbacks: {
            onTrainBegin: () => console.log("Training Starting..."),
            onTrainEnd: () => console.log("Training Finished."),
            onBatchEnd: (num, logs) => {
                return tf.nextFrame(); 
            },
            onEpochEnd: (num, logs) => {
                console.log(logs)
                console.log("EPOCH NUM: ", num);
                lossP.html('LOSS: ' + logs.val_loss);
            }
        }
    }
    return await model.fit(xs, ys, options);

}

function draw() {
    let r = redSlider.value();
    let g = greenSlider.value();
    let b = blueSlider.value();

    background(r, g, b);
    tf.tidy(() => {
        const predX = tf.tensor2d([[r / 255, g / 255, b / 255]]);
        let results = model.predict(predX);
        let index = results.argMax(1).dataSync()[0];
    
        let label = labelList[index];
        console.log(label);
    
        labelP.html(label);
    })

}