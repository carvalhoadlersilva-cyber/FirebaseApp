import 'package:flutter_test/flutter_test.dart';

abstract class Pessoa {
  late int _id;
  String nome;

  Pessoa(this.nome);

  int get id => _id;

  set id(int id) {
    if (id > 0) {
      _id = id;
    } else {
      throw ArgumentError('Identificador deve ser não negativo.');
    }
  }
}

// EXERCÍCIO 5: Classe Professor estendendo Pessoa
class Professor extends Pessoa {
  Professor(super.nome);
}

mixin Ano {
  late int _ano;

  int get ano => _ano;

  set ano(int ano) {
    if (ano > 0) {
      _ano = ano;
    } else {
      throw ArgumentError('Ano deve ser não negativo.');
    }
  }
}

class Aluno extends Pessoa with Ano {
  Aluno(super.nome, int ano) {
    this.ano = ano;
  }
}

class Disciplina {
  String nome;
  Disciplina(this.nome);
}

// EXERCÍCIO 5: Turma atualizada para conter um Professor
class Turma with Ano {
  Disciplina disciplina;
  Professor professor;
  final List<Aluno> _alunos = [];

  Turma(this.disciplina, this.professor, int ano) {
    this.ano = ano;
  }

  void matricular(Aluno aluno) {
    if (aluno.ano == ano) {
      _alunos.add(aluno);
    } else {
      throw ArgumentError('Ano deve ser mesmo.');
    }
  }
}

class Historico extends Turma {
  Map<Aluno, List<double>> notas = {};

  Historico(super.disciplina, super.professor, super.ano);

  @override
  void matricular(Aluno aluno) {
    super.matricular(aluno);
    notas[aluno] = [];
  }

  double media(Aluno aluno) {
    if (notas[aluno] == null || notas[aluno]!.isEmpty) return 0.0;
    double soma = 0;
    for (double nota in notas[aluno]!) {
      soma += nota;
    }
    return soma / notas[aluno]!.length;
  }

  // EXERCÍCIO 6: Método para verificar se o aluno foi aprovado (média > 6)
  bool isAprovado(Aluno aluno) {
    return media(aluno) > 6.0;
  }
}

// EXERCÍCIO 7: Testes modificados para suportar as alterações
void main() {
  test('Testar matrícula de alunos, média e aprovação', () {
    // 1. Criar objeto Professor
    Professor professor1 = Professor('Carlos Silva');

    Disciplina disciplina1 = Disciplina('Flutter');
    
    // 2. Instanciar Histórico/Turma com o Professor
    Historico historico1 = Historico(disciplina1, professor1, 2023);

    // 3. Cadastrar primeiro aluno
    Aluno aluno1 = Aluno('Maria', 2023);
    aluno1.id = 1;
    historico1.matricular(aluno1);
    
    // Atribuir notas ao aluno para testar a aprovação
    historico1.notas[aluno1] = [7.0, 8.0]; // Média = 7.5
    
    double mediaAluno1 = historico1.media(aluno1);
    bool aprovadoAluno1 = historico1.isAprovado(aluno1);

    // Saídas no terminal para confirmar a execução
    print('Aluno: ${aluno1.nome} | Média: $mediaAluno1 | Aprovado: $aprovadoAluno1');

    expect(mediaAluno1, 7.5);
    expect(aprovadoAluno1, true);

    // 4. Cadastrar segundo aluno com erros esperados
    Aluno aluno2 = Aluno('Paula', 2022);
    
    try {
      aluno2.id = 0;
    } catch (error) {
      expect(error, isA<ArgumentError>());
      print('Erro capturado no ID do aluno 2: $error');
    }

    try {
      historico1.matricular(aluno2);
    } catch (error) {
      expect(error, isA<ArgumentError>());
      print('Erro capturado na matrícula do aluno 2: $error');
    }
  });
}