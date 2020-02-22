package com.example.block_em_all.models;

public class BlockedNumber {
    public String blockingPattern;
    public boolean isBlockingActive;

    public BlockedNumber() {
    }

    public BlockedNumber(String blockingPattern, boolean isBlockingActive) {
        this.blockingPattern = blockingPattern;
        this.isBlockingActive = isBlockingActive;
    }
}
