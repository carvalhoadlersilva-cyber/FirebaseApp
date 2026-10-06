import 'package:flutter_test/flutter_test.dart';

// Variável global com os dados de entrada
Map<String, List<double>> alunos = {
  'Maria': [8.0, 9.0],
  'Bruna': [7.0, 7.0],
  'Carla': [10.0, 9.0],
};

void main() {
  test('Adicionar elemento', () {
    alunos.putIfAbsent('Elena', () => [9.0, 8.0]);
    expect(alunos.containsKey('Elena'), isTrue);
    expect(alunos['Elena'], [9.0, 8.0]);
  });

  test('Adicionar outro dicionário', () {
    alunos.addAll({
      'Elena': [9.0, 8.0],
      'Luiza': [8.0, 9.0],
    });
    expect(alunos.containsKey('Elena'), isTrue);
    expect(alunos.containsKey('Luiza'), isTrue);
  });

  test('Remover elemento', () {
    alunos.remove('Bruna');
    expect(alunos.containsKey('Bruna'), isFalse);
  });

  test('Atualizar elemento', () {
    alunos.update('Carla', (value) => [9.0, 8.0]);
    expect(alunos['Carla'], [9.0, 8.0]);
    alunos['Carla'] = [8.0, 9.0];
    expect(alunos['Carla'], [8.0, 9.0]);
  });

  test('Testar percorrer dicionário', () {
    expect(alunos.keys, ['Maria', 'Carla', 'Elena', 'Luiza']);
    expect(alunos.values, [
      [8.0, 9.0],
      [8.0, 9.0],
      [9.0, 8.0],
      [8.0, 9.0],
    ]);
    double soma = 0;
    alunos.forEach((key, value) {
      for (double nota in value) {
        soma += nota;
      }
    });
    expect(soma, 68.0);
  });

  // CORREÇÃO: O teste 'Calcular médias' agora está DENTRO da função main()
  test('Calcular médias', () {
    Map<String, double> medias = {};

    // LÓGICA DO CÁLCULO: Percorre cada aluno e calcula a média das notas
    alunos.forEach((nome, listaNotas) {
      double soma = listaNotas.reduce((a, b) => a + b);
      medias[nome] = soma / listaNotas.length;
    });

    expect(medias, {'Maria': 8.5, 'Carla': 8.5, 'Elena': 8.5, 'Luiza': 8.5});
  });

} // 👈 A chave da função main() deve ser a ÚLTIMA linha do arquivo