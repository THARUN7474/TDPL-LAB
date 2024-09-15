#include <stdio.h>
#include <string.h>

#define MAX_TICKETS 100
#define MAX_AGENTS 10
#define MAX_FEEDBACK_QUESTIONS 3

typedef struct
{
    int id;
    char description[256];
    char customerName[50];
    char status[20];
    int priority;
    int agentId;
    char feedbackQuestions[MAX_FEEDBACK_QUESTIONS][100];
    char feedbackAnswers[MAX_FEEDBACK_QUESTIONS][100];
} Ticket;

typedef struct
{
    int id;
    char name[50];
    int available; // 1 = available, 0 = busy
} Agent;

Ticket tickets[MAX_TICKETS];
Agent agents[MAX_AGENTS] = {
    {1, "Agent 1", 1},
    {2, "Agent 2", 1},
    {3, "Agent 3", 1},
    {4, "Agent 4", 1},
    {5, "Agent 5", 1},
};
int ticketCount = 0;
int nextAgentIndex = 0;

void assignTicketToAgent(int ticketIndex)
{
    if (nextAgentIndex >= MAX_AGENTS)
    {
        nextAgentIndex = 0; // Reset to start the round-robin cycle
    }

    int assignedAgent = nextAgentIndex; // Get the next agent in the round-robin cycle
    tickets[ticketIndex].agentId = agents[assignedAgent].id;
    strcpy(tickets[ticketIndex].status, "Assigned");
    agents[assignedAgent].available = 0;

    printf("Ticket ID %d assigned to %s.\n", tickets[ticketIndex].id, agents[assignedAgent].name);

    nextAgentIndex++;
}

void createTicket()
{
    if (ticketCount < MAX_TICKETS)
    {
        tickets[ticketCount].id = ticketCount + 1;
        printf("Enter description: ");
        fgets(tickets[ticketCount].description, 256, stdin);
        printf("Enter customer name: ");
        fgets(tickets[ticketCount].customerName, 50, stdin);
        tickets[ticketCount].description[strcspn(tickets[ticketCount].description, "\n")] = '\0';
        tickets[ticketCount].customerName[strcspn(tickets[ticketCount].customerName, "\n")] = '\0';
        strcpy(tickets[ticketCount].status, "Open");
        printf("Enter priority (1-5): ");
        scanf("%d", &tickets[ticketCount].priority);
        getchar();
        assignTicketToAgent(ticketCount);
        ticketCount++;
        printf("Ticket created and assigned successfully.\n");
    }
    else
    {
        printf("Ticket storage is full.\n");
    }
}

void viewTickets()
{
    for (int i = 0; i < ticketCount; i++)
    {
        printf("Ticket ID: %d, Description: %s, Customer: %s, Status: %s, Priority: %d, Assigned Agent ID: %d\n",
               tickets[i].id, tickets[i].description, tickets[i].customerName, tickets[i].status, tickets[i].priority, tickets[i].agentId);

        if (strcmp(tickets[i].status, "Resolved") == 0)
        {
            printf("Feedback:\n");
            for (int j = 0; j < MAX_FEEDBACK_QUESTIONS; j++)
            {
                if (strlen(tickets[i].feedbackQuestions[j]) > 0)
                {
                    printf("  %s: %s\n", tickets[i].feedbackQuestions[j], tickets[i].feedbackAnswers[j]);
                }
            }
        }
    }
}

void updateTicketStatus()
{
    int id;
    printf("Enter ticket ID to update status: ");
    scanf("%d", &id);
    getchar();
    for (int i = 0; i < ticketCount; i++)
    {
        if (tickets[i].id == id)
        {
            printf("Enter new status (In Progress/Resolved): ");
            fgets(tickets[i].status, 20, stdin);
            tickets[i].status[strcspn(tickets[i].status, "\n")] = '\0';

            if (strcmp(tickets[i].status, "Resolved") == 0)
            {
                printf("Ticket resolved. Requesting customer feedback...\n");
                char *questions[MAX_FEEDBACK_QUESTIONS] = {
                    "How would you rate the service?",
                    "Was your issue resolved promptly?",
                    "Would you recommend our service?"};

                for (int j = 0; j < MAX_FEEDBACK_QUESTIONS; j++)
                {
                    strcpy(tickets[i].feedbackQuestions[j], questions[j]);
                    printf("%s ", questions[j]);
                    fgets(tickets[i].feedbackAnswers[j], 100, stdin);
                    tickets[i].feedbackAnswers[j][strcspn(tickets[i].feedbackAnswers[j], "\n")] = '\0'; // Remove newline
                }

                printf("Thank you for your feedback!\n");

                for (int j = 0; j < MAX_AGENTS; j++)
                {
                    if (agents[j].id == tickets[i].agentId)
                    {
                        agents[j].available = 1;
                        break;
                    }
                }
            }
            printf("Ticket status updated successfully.\n");
            return;
        }
    }
    printf("Ticket ID not found.\n");
}

void viewFeedbacks()
{
    printf("All Feedbacks:\n");
    for (int i = 0; i < ticketCount; i++)
    {
        if (strcmp(tickets[i].status, "Resolved") == 0)
        {
            printf("Ticket ID: %d, Customer: %s\n", tickets[i].id, tickets[i].customerName);
            for (int j = 0; j < MAX_FEEDBACK_QUESTIONS; j++)
            {
                if (strlen(tickets[i].feedbackQuestions[j]) > 0)
                {
                    printf("  %s: %s\n", tickets[i].feedbackQuestions[j], tickets[i].feedbackAnswers[j]);
                }
            }
            printf("\n");
        }
    }
}

int main()
{
    int choice;
    do
    {
        printf("1. Create Ticket\n2. View Tickets\n3. Update Ticket Status\n4. View Feedbacks\n5. Exit\n");
        printf("Enter choice: ");
        scanf("%d", &choice);
        getchar();
        switch (choice)
        {
        case 1:
            createTicket();
            break;
        case 2:
            viewTickets();
            break;
        case 3:
            updateTicketStatus();
            break;
        case 4:
            viewFeedbacks();
            break;
        case 5:
            printf("Exiting...\n");
            break;
        default:
            printf("Invalid choice.\n");
        }
    } while (choice != 5);
    return 0;
}
