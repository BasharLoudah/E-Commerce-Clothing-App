 main() {
  printnumber(3,(){});
}
printnumber(int num ,Function() onprint ){
  print(num);
  onprint();
}