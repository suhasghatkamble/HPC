#include <stdio.h>

int is_prime(int n) {
    if (n <= 1) {
        return 0; // 0 and 1 are not prime numbers
    }
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            return 0; // if n is divisible by any number between 2 and sqrt(n), it's not prime
        }
    }
    return 1; // if n is not divisible by any number between 2 and sqrt(n), it's prime
}

int main() {
    int num;
    printf("Enter a number: ");
    scanf("%d", &num);

    if (is_prime(num)) {
        printf("%d is a prime number.\n", num);
    } else {
        printf("%d is not a prime number.\n", num);
    }

    return 0;
}