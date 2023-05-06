extension Regex on String {
  // Methods
  bool isInvalidUser() {
    return !RegExp(r"^[a-zA-Z][a-zA-Z0-9áàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]*$").hasMatch(this);
  }

  List<String> isInvalidPassword() {
    final bool containSpecialCharacters;
    final bool containNumbers;
    final bool containUpperCharacters;
    final bool greaterThanSix;
    List<String> list = [];

    containSpecialCharacters = contains(RegExp(r"[!@#$%/\^&*~(),.-?:{}|<=>]")); // Tem caractere especial
    containNumbers = contains(RegExp(r"[0-9]")); // Tem numero
    containUpperCharacters = contains(RegExp(r"[A-Z]")); // Tem caractere maiúsculo
    greaterThanSix = length >= 7;

    containSpecialCharacters ? null : list.add("Não contém caracteres especiais");
    containNumbers ? null : list.add("Não contém números");
    containUpperCharacters ? null : list.add("Não contém caracteres maiúsculos");
    greaterThanSix ? null : list.add("No mínimo 7 caracteres");

    return list;
  }

  bool isInvalidEmail() {
    return !RegExp(r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$").hasMatch(this);
  }

  bool isValidCPF() {
    return RegExp(r"^[0-9]{11}$").hasMatch(this);
  }

  bool isValidCNPJ() {
    return RegExp(r"^[0-9]{8}[0]{3}[0-9]{3}$").hasMatch(this);
  }

  bool isNotValidCellPhone() {
    return !RegExp(r"^\([0-9]{2}\) [0-9] [0-9]{4}-[0-9]{4}$").hasMatch(this);
  }
}
