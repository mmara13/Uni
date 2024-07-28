#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define NUM_THREADS 2
#define NUM_ITERATIONS 5

//var globale
char *message = "Hello, World!";
sem_t mutex; //semafor pt protectia seciunii crit

//functia executata de fiecare thread
void *printMessage(void *threadID) {
    long tid = (long)threadID;

    for (int i = 0; i < NUM_ITERATIONS; ++i) {
        sem_wait(&mutex); //asteapta semaforul sa intre in seciunea crit
        for (int j = 0; j < 13; ++j) {
            printf("%c", message[j]);
            fflush(stdout);
            usleep(100); //intarziere ca sa crestem sansele race conditionului
        }
        printf("\n");
        sem_post(&mutex); //eliberam semaforul pt a face exit
    }

    pthread_exit(NULL);
}

int main() {
    pthread_t threads[NUM_THREADS];
    int rc;
    long t;

    //initializez semafor
    sem_init(&mutex, 0, 1);

    //creare threads
    for (t = 0; t < NUM_THREADS; ++t) {
        printf("Creere thread %ld\n", t);
        rc = pthread_create(&threads[t], NULL, printMessage, (void *)t);
        if (rc) {
            fprintf(stderr, "Eroare:codul returnat de pthread_create() este %d\n", rc);
            exit(-1);
        }
    }

    //asteptare ca toate threadurile sa termine Wait for all threads to finish
    for (t = 0; t < NUM_THREADS; ++t) {
        pthread_join(threads[t], NULL);
        printf("Thread %ld alaturat\n", t);
    }

    //stergere semafor
    sem_destroy(&mutex);

    return 0;
}

