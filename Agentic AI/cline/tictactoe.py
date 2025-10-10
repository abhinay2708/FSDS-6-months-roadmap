import streamlit as st

# Initialize game state
def initialize_game():
    if 'board' not in st.session_state:
        st.session_state.board = [['' for _ in range(3)] for _ in range(3)]
    if 'current_player' not in st.session_state:
        st.session_state.current_player = 'X'
    if 'game_over' not in st.session_state:
        st.session_state.game_over = False
    if 'winner' not in st.session_state:
        st.session_state.winner = None

# Handle player move
def make_move(row, col):
    if st.session_state.board[row][col] == '' and not st.session_state.game_over:
        st.session_state.board[row][col] = st.session_state.current_player
        if check_win(st.session_state.current_player):
            st.session_state.game_over = True
            st.session_state.winner = st.session_state.current_player
        elif check_draw():
            st.session_state.game_over = True
            st.session_state.winner = 'Draw'
        else:
            st.session_state.current_player = 'O' if st.session_state.current_player == 'X' else 'X'

# Check for win condition
def check_win(player):
    # Check rows
    for row in st.session_state.board:
        if all([cell == player for cell in row]):
            return True
    # Check columns
    for col in range(3):
        if all([st.session_state.board[row][col] == player for row in range(3)]):
            return True
    # Check diagonals
    if all([st.session_state.board[i][i] == player for i in range(3)]):
        return True
    if all([st.session_state.board[i][2 - i] == player for i in range(3)]):
        return True
    return False

# Check for draw condition
def check_draw():
    return all([cell != '' for row in st.session_state.board for cell in row])

# Reset game
def reset_game():
    st.session_state.board = [['' for _ in range(3)] for _ in range(3)]
    st.session_state.current_player = 'X'
    st.session_state.game_over = False
    st.session_state.winner = None
