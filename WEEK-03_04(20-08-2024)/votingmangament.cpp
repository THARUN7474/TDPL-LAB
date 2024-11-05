#include <bits/stdc++.h>
using namespace std;

class Voter {
public:
    int voterID;
    string name;
    int age;
    string address;
    string password; 
    bool hasVoted;

    Voter(int id, string name, int age, string address, string password)
        : voterID(id), name(name), age(age), address(address), password(password), hasVoted(false) {}
};

class Candidate {
public:
    int candidateID;
    string name;
    string party;
    int votes;

    Candidate(int id, string name, string party)
        : candidateID(id), name(name), party(party), votes(0) {}
};

class Election {
private:
    vector<Voter> voters;
    vector<Candidate> candidates;
    int totalVotes;

    bool verifyVoter(int voterID, string password) {
        for (auto &voter : voters) {
            if (voter.voterID == voterID && voter.password == password && !voter.hasVoted) {
                return true;
            }
        }
        return false;
    }

public:
    Election() : totalVotes(0) {}

    void registerVoter(int id, string name, int age, string address, string password) {
        voters.push_back(Voter(id, name, age, address, password));
    }

    void addCandidate(int id, string name, string party) {
        candidates.push_back(Candidate(id, name, party));
    }

    void castVote(int voterID, string password, int candidateID) {
        if (verifyVoter(voterID, password)) {
            for (auto &voter : voters) {
                if (voter.voterID == voterID) {
                    voter.hasVoted = true;
                    for (auto &candidate : candidates) {
                        if (candidate.candidateID == candidateID) {
                            candidate.votes++;
                            totalVotes++;
                            cout << "Vote cast successfully by " << voter.name << "!!" << endl;
                            displayRealTimeResults(); 
                            return;
                        }
                    }
                }
            }
        } else {
            cout << "Voter verification failed for " << voterID << "!" << endl;
        }
    }

    void tallyResults() {
        cout << "Final Election Results:\n";
        for (auto &candidate : candidates) {
            cout << "Candidate: " << candidate.name << " | Votes: " << candidate.votes << endl;
        }
        cout << "Total Votes Cast: " << totalVotes << endl;
    }

    void displayRealTimeResults() {
        cout << "Real-Time Election Results:\n";
        for (auto &candidate : candidates) {
            cout << "Candidate: " << candidate.name << " | Votes: " << candidate.votes << endl;
        }
        cout << "Total Votes So Far: " << totalVotes << endl;
    }
};

int main() {
    Election election;


   
    election.registerVoter(1, "Tharun", 22, "Indhravathi-s9", "pass123");
    election.registerVoter(2, "Harsha", 24, "Indhravathi-s1", "harsha456");
    election.registerVoter(3, "Navya", 23, "Girlshostel-f10", "navya789");
    election.registerVoter(4, "Santhu", 25, "Indhravathi-s3", "santhu001");
    election.registerVoter(5, "Revak", 21, "Indhravathi-s4", "revak999");

    election.addCandidate(1, "Chirag", "Party A");
    election.addCandidate(2, "Shreya", "Party B");
    election.addCandidate(3, "Ash", "Party C");

    election.castVote(1, "pass123", 1);  
    election.castVote(2, "harsha456", 2); 
    election.castVote(3, "navya789", 1); 
    election.castVote(4, "santhu001", 3);  
    election.castVote(5, "revak999", 3);  

   
    election.tallyResults();

    return 0;
}
