let seat = () => {
    var list = document.querySelectorAll(".cinema-wrap");
    for(var i=0; i < list.length; i++){
        var cinema = new Hacademy.Reservation(list[i]);
    }
}