#include<iostream>
#include<string>
#include<vector>
using namespace std;

void removeLeftRecursion(string& nonTerminal, vector<string>& productions) {
    string nonTerminalPrime = nonTerminal + "\'";  
    vector<string> leftRecursion, noLeftRecursion;

    for (auto& prod : productions) {
        if (prod[0] == nonTerminal[0])
            leftRecursion.push_back(prod.substr(1) + nonTerminalPrime);
        else
            noLeftRecursion.push_back(prod + nonTerminalPrime);
    }

    noLeftRecursion.push_back("#");
    productions = noLeftRecursion;
    productions.push_back(nonTerminalPrime);
    productions.insert(productions.end(), leftRecursion.begin(), leftRecursion.end());
}

void removeLeftFactoring(vector<string>& productions) {
    vector<string> newProductions, factoredProds;
    string commonPrefix;

    for (size_t i = 0; i < productions.size(); ++i) {
        for (size_t j = i + 1; j < productions.size(); ++j) {
            int commonLength = 0;
            while (commonLength < productions[i].size() && commonLength < productions[j].size() &&
                   productions[i][commonLength] == productions[j][commonLength]) ++commonLength;

            if (commonLength > 0) {
                commonPrefix = productions[i].substr(0, commonLength);
                string newNonTerminal = "X";
                newProductions.push_back(commonPrefix + newNonTerminal);
                factoredProds.push_back(productions[i].substr(commonLength));
                factoredProds.push_back(productions[j].substr(commonLength));
                productions[i] = commonPrefix + newNonTerminal;
                productions[j] = commonPrefix + newNonTerminal;
                break;
            }
        }
    }

    productions.insert(productions.end(), factoredProds.begin(), factoredProds.end());
}

int main() {
    string nonTerminal, temp;
    vector<string> productions;

    cout << "Enter the Parent Non-Terminal: ";
    cin >> nonTerminal;

    cout << "Enter the number of productions: ";
    int n;
    cin >> n;

    cout << "Enter Productions:\n";
    for (int i = 0; i < n; ++i) {
        cout << "Production " << i + 1 << ": ";
        cin >> temp;
        productions.push_back(temp);
    }

    cout << "\nOriginal Productions: " << nonTerminal << " -> ";
    for (const auto& prod : productions)
        cout << prod << "|";
    cout << endl;

    // Left Recursion Removal
    removeLeftRecursion(nonTerminal, productions);
    cout << "\nAfter Removing Left Recursion:\n" << nonTerminal << " -> ";
    for (size_t i = 0; i < productions.size(); ++i)
        cout << productions[i] << (i < productions.size() - 1 ? "|" : "") ;

    // Left Factoring Removal
    removeLeftFactoring(productions);
    cout << "\nAfter Removing Left Factoring:\n";
    for (size_t i = 0; i < productions.size(); ++i)
        cout << nonTerminal << " -> " << productions[i] << endl;

    return 0;
}
