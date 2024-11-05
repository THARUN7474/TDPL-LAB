#include <bits/stdc++.h>
using namespace std;

class User
{
public:
    int userID;
    string name;
    vector<int> borrowedResources;
    map<int, string> reviews;

    User(int id, string name) : userID(id), name(name) {}

    void addReview(int resourceID, const string &review)
    {
        reviews[resourceID] = review;
        cout << name << " added a review for resource ID " << resourceID << ": " << review << endl;
    }
};

class Resource
{
public:
    int resourceID;
    string title;
    string author;
    bool isBorrowed;
    vector<string> userReviews;

    Resource(int id, const string &title, const string &author)
        : resourceID(id), title(title), author(author), isBorrowed(false) {}

    void addReview(const string &review)
    {
        userReviews.push_back(review);
    }

    void displayReviews() const
    {
        cout << "Reviews for " << title << ":\n";
        for (const string &review : userReviews)
        {
            cout << "- " << review << endl;
        }
    }
};

class Library
{
private:
    vector<User> users;
    const int borrowDuration = 7 * 24 * 60 * 60;

public:
    vector<Resource> resources;
    void registerUser(int id, const string &name)
    {
        users.push_back(User(id, name));
    }

    void addResource(int id, const string &title, const string &author)
    {
        resources.push_back(Resource(id, title, author));
    }

    void borrowResource(int userID, int resourceID)
    {
        for (auto &user : users)
        {
            if (user.userID == userID)
            {
                for (auto &resource : resources)
                {
                    if (resource.resourceID == resourceID && !resource.isBorrowed)
                    {
                        resource.isBorrowed = true;
                        user.borrowedResources.push_back(resourceID);
                        cout << user.name << " borrowed " << resource.title << " successfully!" << endl;
                        return;
                    }
                }
            }
        }
        cout << "Borrowing failed!" << endl;
    }

    void returnResource(int userID, int resourceID)
    {
        for (auto &user : users)
        {
            if (user.userID == userID)
            {
                for (auto &resource : resources)
                {
                    if (resource.resourceID == resourceID && resource.isBorrowed)
                    {
                        resource.isBorrowed = false;
                        user.borrowedResources.erase(
                            remove(user.borrowedResources.begin(), user.borrowedResources.end(), resourceID),
                            user.borrowedResources.end());
                        cout << user.name << " returned " << resource.title << " successfully!" << endl;
                        return;
                    }
                }
            }
        }
        cout << "Return failed!" << endl;
    }

    void notifyOverdue()
    {
        time_t now = time(0);
        for (const auto &user : users)
        {
            for (const auto &borrowed : user.borrowedResources)
            {
                time_t borrowTime = now - borrowDuration;
                if (difftime(now, borrowTime) > borrowDuration)
                {
                    cout << "Overdue notification: " << user.name << ", please return resource ID " << borrowed << " immediately!" << endl;
                }
            }
        }
    }

    void addReview(int userID, int resourceID, const string &review)
    {
        for (auto &user : users)
        {
            if (user.userID == userID)
            {
                for (auto &resource : resources)
                {
                    if (resource.resourceID == resourceID)
                    {
                        user.addReview(resourceID, review);
                        resource.addReview(review);
                        return;
                    }
                }
            }
        }
    }

    void recommendResources() const
    {
        cout << "Resource Recommendations based on popular reviews:\n";
        for (const auto &resource : resources)
        {
            if (!resource.userReviews.empty())
            {
                cout << resource.title << " by " << resource.author << endl;
            }
        }
    }
};

int main()
{
    Library library;

    library.registerUser(1, "Tharun");
    library.registerUser(2, "Harsha");
    library.registerUser(3, "Navya");
    library.registerUser(4, "Chirag");

    library.addResource(1, "C++ Programming", "Bjarne Stroustrup");
    library.addResource(2, "Effective Java", "Joshua Bloch");
    library.addResource(3, "Clean Code", "Robert C. Martin");

    library.borrowResource(1, 1);
    library.borrowResource(2, 2);

    library.returnResource(1, 1);
    library.addReview(1, 1, "A must-read for every C++ developer!");
    library.addReview(2, 2, "Excellent resource for Java enthusiasts.");
    library.addReview(3, 3, "Clean Code is a great book on software craftsmanship.");

    for (const auto &resource : library.resources)
    {
        resource.displayReviews();
    }

    library.recommendResources();

    library.notifyOverdue();

    return 0;
}
