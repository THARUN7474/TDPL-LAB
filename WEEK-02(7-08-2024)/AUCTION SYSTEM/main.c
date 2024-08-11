#include <stdio.h>
#include <string.h>
#include <time.h>

#define MAX_ITEMS 100
#define MAX_BIDS 100
#define MAX_USERS 50

typedef struct {
    int id;
    char description[256];
    int startingBid;
    int highestBid;
    char highestBidder[50];
    time_t endTime;
    int active;
} AuctionItem;

typedef struct {
    int id;
    char username[50];
} User;

typedef struct {
    int itemId;
    int bidAmount;
    char bidder[50];
} Bid;

AuctionItem auctionItems[MAX_ITEMS];
User users[MAX_USERS];
Bid bids[MAX_BIDS];
int itemCount = 0;
int bidCount = 0;
int userCount = 0;

void listAuctionItem() {
    if (itemCount < MAX_ITEMS) {
        auctionItems[itemCount].id = itemCount + 1;
        printf("Enter item description: ");
        getchar(); // Consume newline left over by previous input
        fgets(auctionItems[itemCount].description, 256, stdin);
        printf("Enter starting bid: ");
        scanf("%d", &auctionItems[itemCount].startingBid);
        auctionItems[itemCount].highestBid = auctionItems[itemCount].startingBid;
        strcpy(auctionItems[itemCount].highestBidder, "None");
        printf("Enter auction duration in seconds: ");
        int duration;
        scanf("%d", &duration);
        auctionItems[itemCount].endTime = time(NULL) + duration;
        auctionItems[itemCount].active = 1;
        itemCount++;
        printf("Auction item listed successfully.\n");
    } else {
        printf("Auction item storage is full.\n");
    }
}

void placeBid() {
    if (bidCount < MAX_BIDS) {
        int itemId;
        printf("Enter item ID to bid on: ");
        scanf("%d", &itemId);
        
        if (itemId > 0 && itemId <= itemCount && auctionItems[itemId - 1].active) {
            Bid newBid;
            newBid.itemId = itemId;
            printf("Enter your username: ");
            getchar(); // Consume newline
            fgets(newBid.bidder, 50, stdin);
            newBid.bidder[strcspn(newBid.bidder, "\n")] = '\0'; // Remove newline
            printf("Enter your bid amount: ");
            scanf("%d", &newBid.bidAmount);
            
            if (newBid.bidAmount > auctionItems[itemId - 1].highestBid) {
                auctionItems[itemId - 1].highestBid = newBid.bidAmount;
                strcpy(auctionItems[itemId - 1].highestBidder, newBid.bidder);
                bids[bidCount++] = newBid;
                printf("Bid placed successfully!\n");
            } else {
                printf("Bid amount must be higher than the current highest bid.\n");
            }
        } else {
            printf("Invalid item ID or auction has ended.\n");
        }
    } else {
        printf("Bid storage is full.\n");
    }
}

void checkAuctions() {
    time_t currentTime = time(NULL);
    for (int i = 0; i < itemCount; i++) {
        if (auctionItems[i].active && difftime(auctionItems[i].endTime, currentTime) <= 0) {
            auctionItems[i].active = 0;
            printf("Auction ended for item ID %d: %s\n", auctionItems[i].id, auctionItems[i].description);
            printf("Winning bidder: %s with bid: $%d\n", auctionItems[i].highestBidder, auctionItems[i].highestBid);
        }
    }
}

void viewAuctionItems() {
    for (int i = 0; i < itemCount; i++) {
        if (auctionItems[i].active) {
            printf("Item ID: %d, Description: %s", auctionItems[i].id, auctionItems[i].description);
            printf("Starting Bid: $%d, Highest Bid: $%d, Highest Bidder: %s\n", 
                   auctionItems[i].startingBid, auctionItems[i].highestBid, auctionItems[i].highestBidder);
        }
    }
}

void viewAuctionHistory() {
    for (int i = 0; i < itemCount; i++) {
        if (!auctionItems[i].active) {
            printf("Item ID: %d, Description: %s", auctionItems[i].id, auctionItems[i].description);
            printf("Winning Bid: $%d by %s\n", auctionItems[i].highestBid, auctionItems[i].highestBidder);
        }
    }
}

void provideFeedback() {
    char feedback[256];
    printf("Please provide your feedback on the auction experience: ");
    getchar(); // Consume newline
    fgets(feedback, 256, stdin);
    printf("Thank you for your feedback: %s\n", feedback);
}

int main() {
    int choice;
    do {
        printf("1. List Auction Item\n2. Place Bid\n3. View Auction Items\n4. Check Auctions\n5. View Auction History\n6. Provide Feedback\n7. Exit\n");
        printf("Enter choice: ");
        scanf("%d", &choice);
        switch (choice) {
            case 1:
                listAuctionItem();
                break;
            case 2:
                placeBid();
                break;
            case 3:
                viewAuctionItems();
                break;
            case 4:
                checkAuctions();
                break;
            case 5:
                viewAuctionHistory();
                break;
            case 6:
                provideFeedback();
                break;
            case 7:
                printf("Exiting...\n");
                break;
            default:
                printf("Invalid choice.\n");
        }
    } while (choice != 7);
    return 0;
}
