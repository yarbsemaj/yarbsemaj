const fs = require('fs')
const crypto = require("crypto");

let ix = 11
let iy = 13

let ax = ix + 56
let ay = iy + 6

let stars = []

while (stars.length < 32) {
    let x = getRandomInt(80)
    let y = getRandomInt(34)

    if (!(ix <= x && x <= ax && iy <= y && y <= ay)) {
        stars.push({ x, y })
    } else {
        console.log({ x, y })
    }
}

stars = stars.reduce((prev, current) => {
    return prev += `    .byte       ${current.y},${current.x}\n`
}, "")

fs.writeFileSync('./stars.asm', stars)

function getRandomInt(max) {
    return crypto.randomInt(1, max);
}