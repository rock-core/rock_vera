    , some_value(2)

int f(int a, int b) {
}

int g() {
    // just right
    f(10, 20);
    // space before comma
    f(10 , 20);
    // space missing after comma
    f(10,20);
}

class H {
    int a;
    int b;
    int c;
    H()
        : a(10)
        , b(20)
        , c(20) {
    }
}
