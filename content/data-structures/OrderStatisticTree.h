/**
 * Author: Simon Lindholm
 * Date: 2016-03-22
 * License: CC0
 * Source: hacKIT, NWERC 2015
 * Description: Set especial para achar o nth elemento e o indice de um elemento. Resolve o Kth active element.
 * Para map, mude \texttt{null\_type} para o segundo termo do map.
 * Time: O(\log N)
 * Reviewed: Kauan (05/09/26)
 */
#pragma once

#include <bits/extc++.h> /** keep-include */
using namespace __gnu_pbds;

template<class T>
using Tree = tree<T, null_type, less<T>, rb_tree_tag,
    tree_order_statistics_node_update>;

void example_find_remove_kth_active() {
	Tree<int> t; for(int i = 0; i<n; i++) t.insert(i);
	while(true){
		int kth; cin>>kth;
		auto it = t.find_by_order(kth);
		cout<<*it<<endl;
		t.erase(it);
	}
}
