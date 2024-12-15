const fs = require('fs');
const randomUseragent = require('random-useragent');
const readlineSync = require('readline-sync');

function generateua(count) {
    const userAgents = [];

    for (let i = 0; i < count; i++) {
        const userAgent = randomUseragent.getRandom();
        userAgents.push(userAgent);
    }

    return userAgents;
}

function saveniga(userAgents) {
    const saved = 'ua.txt';

    fs.writeFile(saved, userAgents.join('\n'), (err) => {
        if (err) throw err;
        console.log(`${userAgents.length} user agents have been saved to ${saved}`);
    });
}
console.log('hey!')
console.log('-------------------------')
const uaamount = readlineSync.question('Howmuch?: ');

const rvlnd = generateua(Number(uaamount));
saveniga(rvlnd);