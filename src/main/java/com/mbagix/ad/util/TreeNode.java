package com.mbagix.ad.util;


import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
/**
 * 트리 연산
 *
 * <pre>
 * <b>History:</b>
 *    작성자, 1.1, 2016.3.9 초기작성
 * </pre>
 *
 * @author 홍성철
 * @version 1.2
 * @see    None
 */
@JsonIgnoreProperties({ "parent" })
public class TreeNode<T> implements Iterable<TreeNode<T>> {

	
    public T data;
	
	public String text;
	
	//public boolean enableLinks=false;
    @JsonIgnore
    private TreeNode<T> parent;
    
    //@JsonSerialize(include=JsonSerialize.Inclusion.NON_EMPTY)
    @JsonInclude(JsonInclude.Include.NON_EMPTY) 
    public List<TreeNode<T>> nodes;

    @JsonIgnore
    public boolean isRoot() {
            return parent == null;
    }

    @JsonIgnore
    public List<TreeNode<T>> getList(){
    	return nodes;
    }
    @JsonIgnore
    public boolean isLeaf() {
            return nodes.size() == 0;
    }

    public TreeNode<T> getParent(){
    	return parent;
    }
    public void setParent(TreeNode<T> p){
    	parent = p;
    }
    private List<TreeNode<T>> elementsIndex;

    public TreeNode(T data) {
            this.data = data;
            this.nodes = new LinkedList<TreeNode<T>>();
            this.elementsIndex = new LinkedList<TreeNode<T>>();
            this.elementsIndex.add(this);
            this.text = data.toString();
    }
    
    public TreeNode<T> addChild(T child) {
            TreeNode<T> childNode = new TreeNode<T>(child);
            childNode.parent = this;
            this.nodes.add(childNode);
            this.registerChildForSearch(childNode);
            return childNode;
    }

    @JsonIgnore
    public int getLevel() {
            if (this.isRoot())
                    return 0;
            else
                    return parent.getLevel() + 1;
    }

    private void registerChildForSearch(TreeNode<T> node) {
            elementsIndex.add(node);
            if (parent != null)
                    parent.registerChildForSearch(node);
    }

    public TreeNode<T> findTreeNode(Comparable<T> cmp) {
            for (TreeNode<T> element : this.elementsIndex) {
                    T elData = element.data;
                    if (cmp.compareTo(elData) == 0)
                            return element;
            }

            return null;
    }

    @Override
    public String toString() {
            return data != null ? data.toString()  : "[data null]";
    }

    @Override
    public Iterator<TreeNode<T>> iterator() {
            TreeNodeIter<T> iter = new TreeNodeIter<T>(this);
            return iter;
    }
    
    public static void main(String args[]){
    	TreeNode<String> root = new TreeNode<String>("root");
        {
                TreeNode<String> node0 = root.addChild("node0");
                TreeNode<String> node1 = root.addChild("node1");
                TreeNode<String> node2 = root.addChild("node2");
                {
                        TreeNode<String> node20 = node2.addChild(null);
                        TreeNode<String> node21 = node2.addChild("node21");
                        {
                                TreeNode<String> node210 = node21.addChild("node210");
                                TreeNode<String> node211 = node21.addChild("node211");
                        }
                }
                TreeNode<String> node3 = root.addChild("node3");
                {
                        TreeNode<String> node30 = node3.addChild("node30");
                }
        }
        System.out.println(root);
    }

}
