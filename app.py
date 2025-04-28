from flask import Flask, jsonify, render_template
from flask_cors import CORS
import psycopg2

app = Flask(__name__)
CORS(app)

DB_CONFIG = {
    'dbname': 'rpg_db',
    'user': 'usuario',
    'password': 'senha',
    'host': 'localhost',
    'port': 5432
}

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/aventureiros', methods=['GET'])
def get_aventureiros():
    try:
        # Conectar ao banco de dados
        conn = psycopg2.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # Query para buscar os aventureiros
        query = """
        SELECT a.nome, c.nome AS classe, c.alcance, c.descricao, a.nivel, a.xp, g.nome AS guilda
        FROM public.aventureiro a
        JOIN public.classe c ON a.classe_id = c.id
        LEFT JOIN public.guilda g ON a.guilda_id = g.id
        """
        cursor.execute(query)
        rows = cursor.fetchall()

        # Estruturar os dados em um formato JSON
        aventureiros = [
            {
                'nome': row[0],
                'classe': row[1],
                'alcance': row[2],
                'descricao': row[3],
                'nivel': row[4],
                'xp': row[5],
                'guilda': row[6] or 'Sem guilda'
            }
            for row in rows
        ]

        # Fechar conexão
        cursor.close()
        conn.close()

        return jsonify(aventureiros)
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
    # except psycopg2.Error as db_error:
    #     app.logger.error(f"Erro no banco de dados: {db_error}")
    #     return jsonify({'error': 'Erro ao acessar o banco de dados'}), 500
    # except Exception as e:
    #     app.logger.error(f"Erro inesperado: {e}")
    #     return jsonify({'error': 'Erro inesperado no servidor'}), 500

if __name__ == '__main__':
    app.run(debug=True)