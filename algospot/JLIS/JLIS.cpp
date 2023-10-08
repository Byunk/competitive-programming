#include <iostream>
#include <vector>
#include <string>
#include <string.h>
#include <queue>
#include <algorithm>

using namespace std;

int C, N, M;
int A[100], B[100];
int cache[101][101];

int JLIS (int a, int b) {
	int& ret = cache[a+1][b+1];
	if (ret != -1) return ret;
	ret = 1;

	int n;
	if (a != -1 && b != -1) {
		if (A[a] < B[b]) {
			n = A[a];
			ret = max(ret, 1 + JLIS(a+1, b));
		} else {
			n = B[b];
			ret = max(ret, 1 + JLIS(a, b+1));
		}
	}

	for (int i = a+1; i < N; ++i) {
		for (int j = b+1; j < M; ++j) {
			if ((a == -1 || A[i] > n) && (b == -1 || B[j] > n)) {
				ret = max(ret, 1 + JLIS(i, j));
			}
		}
	}
	cout << a << " " << b << " " << ret << endl;

	return ret;
}

void solve () {
	cin >> C;
	for (int i = 0; i < C; ++i) {
		memset(cache, -1, sizeof(cache));

		cin >> N >> M;
		for (int j = 0; j < N; ++j) {
			cin >> A[j];
		}
		for (int j = 0; j < M; ++j) {
			cin >> B[j];
		}

		cout << JLIS(-1, -1) << endl;
	}
}

int main () {
	freopen("input.txt", "r", stdin);
	solve();
}
