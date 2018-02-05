#ifndef DRAM_H
#define DRAM_H

#include "memory_class.h"
#include "DRAMSim.h"

#define DRAM_WQ_SIZE 48
#define DRAM_RQ_SIZE 48

class DRAM_CONTROLLER : public MEMORY {
  public:
    const string NAME;
    DRAMSim::MultiChannelMemorySystem *mem;

    // queues
    PACKET_QUEUE WQ, RQ;
    long long readData, writeData, readComp, writeComp;

    DRAM_CONTROLLER(string v1) : NAME (v1) {
        mem = DRAMSim::getMemorySystemInstance("ini/DDR3_micron_32M_8B_x8_sg15.ini", "system.ini", "./DRAMSim2", "example_app", DRAM_SIZE);

        DRAMSim::TransactionCompleteCB *read_cb = new DRAMSim::Callback<DRAM_CONTROLLER, void, unsigned, uint64_t, uint64_t>(this, &DRAM_CONTROLLER::read_complete);
        DRAMSim::TransactionCompleteCB *write_cb = new DRAMSim::Callback<DRAM_CONTROLLER, void, unsigned, uint64_t, uint64_t>(this, &DRAM_CONTROLLER::write_complete);
        mem->RegisterCallbacks(read_cb, write_cb, 0);

        WQ.NAME = "DRAM_WQ";
        WQ.SIZE = DRAM_WQ_SIZE;
        WQ.entry = new PACKET [DRAM_WQ_SIZE];

        RQ.NAME = "DRAM_RQ";
        RQ.SIZE = DRAM_RQ_SIZE;
        RQ.entry = new PACKET [DRAM_RQ_SIZE];
        readData = 0;
        writeData = 0;
        readComp = 0;
        writeComp = 0;
    };

    // destructor
    ~DRAM_CONTROLLER() {

    };

    // functions
    int  add_rq(PACKET *packet),
         add_wq(PACKET *packet),
         add_pq(PACKET *packet);

    void return_data(PACKET *packet),
         operate(),
         increment_WQ_FULL(uint64_t address);

    uint32_t get_occupancy(uint8_t queue_type, uint64_t address),
             get_size(uint8_t queue_type, uint64_t address);

    float get_latency();

    int check_dram_queue(PACKET_QUEUE *queue, PACKET *packet);

    // DRAMSIM callbacks
    void read_complete(unsigned, uint64_t, uint64_t);
    void write_complete(unsigned, uint64_t, uint64_t);
    void printStats(uint8_t );
};

#endif
