document.onreadystatechange = updateClock()

function updateClock() {
    const date = new Date()
    document.getElementById("current-time-text").innerText = date.toLocaleTimeString([], { hourCycle: 'h23' })
    const hour = date.getHours()
    if (hour < 5 || hour >= 18) {
        document.getElementById("time-greeting-text").innerText = "Good evening."
    }
    else if (hour < 12) {
        document.getElementById("time-greeting-text").innerText = "Good morning."
    }
    else {
        document.getElementById("time-greeting-text").innerText = "Good afternoon."
    }
}

setInterval(updateClock, 1000)

function doSearch() {
    const query = document.getElementById('search-input').value
    switch (document.getElementById("search-engine-select").value) {
        case 'google':
            window.location.href = `https://www.google.com/search?q=${query}`
            break;
        case 'yandex':
            window.location.href = `https://ya.ru/search/?text=${query}`
            break;
        case 'ddg':
            window.location.href = `https://www.duckduckgo.com/?q=${query}`
    }
}

const searchInput = document.getElementById("search-input")
searchInput.addEventListener("keypress", function onEvent(event) {
    if (event.key === "Enter") {
        document.getElementById("search-button").click();
    }
});
